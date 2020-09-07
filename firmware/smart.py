import time
from machine import WDT, Pin
import network
from umqtt.robust import MQTTClient
from machine import UART
import ure
import uselect
import ujson

def run():
    ID = ure.compile("\\\\(.+)\r\n$")
    HEAD = ure.compile("^/.+")
    TAIL = ure.compile("^\!.+")

    TOPIC = "/p1/{0}/telegram"
    SERIAL = None

    (SEARCH, LOCK) = (0, 1)

    CONF_FILE = "conf.json"
    CONF = None

    time.sleep(10)
    wdt = WDT(timeout=60000)


    def cb(pin):
        pass

    pin = Pin(0, Pin.IN, Pin.PULL_UP)
    pin.irq(trigger=Pin.IRQ_FALLING, handler=cb)

    with open(CONF_FILE) as conf:
        CONF = ujson.load(conf)

    sta_if = network.WLAN(network.STA_IF)
    sta_if.active(True)
    sta_if.connect(CONF["wifi"]["ssid"], CONF["wifi"]["key"])
    time.sleep(10)

    p1 = UART(2, baudrate=115200, bits=8, parity=None, stop=1, invert=UART.INV_RX) # Rx=16 Tx=17
    poll = uselect.poll()
    poll.register(p1, uselect.POLLIN)

    while True:
        poll.poll(1000)
        wdt.feed()
        line = p1.readline()
        if line and ID.search(line):
            try:
                SERIAL = ID.search(line).group(1).decode("utf-8")
                break
            except:
                pass

    mqttc = MQTTClient(SERIAL, CONF["mqtt"]["host"])
    mqttc.connect()

    state = SEARCH
    buf = []

    while True:
        poll.poll(1000)
        wdt.feed()
        line = p1.readline()
        if line:
            print(line)
            if state == SEARCH and HEAD.search(line):
                state = LOCK
                buf.append(line)
            elif state == LOCK:
                buf.append(line)
                if TAIL.search(line):
                    state = SEARCH
                    tgram = b''.join(buf)
                    mqttc.publish(TOPIC.format(SERIAL), tgram)
                    buf = []

