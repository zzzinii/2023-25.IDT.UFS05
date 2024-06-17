# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

import paho.mqtt.client as mqtt
from time import sleep
from ssl import SSLContext, PROTOCOL_TLS_CLIENT, CERT_REQUIRED

IOT_HUB_NAME      = "2023-25-IDT-UFS05"
IOT_HUB_DEVICE_ID = "aaglietti-mqtt-cool"
IOT_HUB_SAS_TOKEN = ""

def on_connect(mqtt_client, obj, flags, rc):
    print("connect: " + str(rc))

def on_publish(mqtt_client, obj, mid):
    print("publish: " + str(mid))

mqtt_client = mqtt.Client(client_id=IOT_HUB_DEVICE_ID, protocol=mqtt.MQTTv311)
mqtt_client.on_connect = on_connect
mqtt_client.on_publish = on_publish

mqtt_client.username_pw_set(username=IOT_HUB_NAME + ".azure-devices.net/" + IOT_HUB_DEVICE_ID + "/?api-version=2021-04-12", 
                            password=IOT_HUB_SAS_TOKEN)

ssl_context = SSLContext(protocol=PROTOCOL_TLS_CLIENT)
ssl_context.load_default_certs()
ssl_context.verify_mode = CERT_REQUIRED
ssl_context.check_hostname = True
mqtt_client.tls_set_context(context=ssl_context)

mqtt_client.connect(host=IOT_HUB_NAME + ".azure-devices.net", port=8883, keepalive=120)

# start the MQTT processing loop
mqtt_client.loop_start()

# send telemetry
#messages = ["Accio", "Aguamenti", "Alarte Ascendare", "Expecto Patronum", "Homenum Revelio"]
messages = ["Accio"]
for i in range(0, len(messages)):
    print("sending message[" + str(i) + "]: " + messages[i])
    mqtt_client.publish("devices/" + IOT_HUB_DEVICE_ID + "/messages/events/", payload=messages[i], qos=1)
    sleep(1)
