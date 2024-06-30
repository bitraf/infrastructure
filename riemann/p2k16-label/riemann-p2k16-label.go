package main

import (
	"log"
	"time"

	mqtt "github.com/eclipse/paho.mqtt.golang"
	"github.com/riemann/riemann-go-client"
)

func main() {
	addr_riemann := "riemann.bitraf.no:5555"
	addr_mqtt := "tcp://mqtt.bitraf.no:1883"

	rm := riemanngo.NewTCPClient(addr_riemann, 5*time.Second)
	err := rm.Connect()
	if err != nil {
		panic(err)
	}

	o := mqtt.NewClientOptions()
	o.AddBroker(addr_mqtt)
	o.SetClientID("p2k16-label-alive")

	mq := mqtt.NewClient(o)

	t := mq.Connect()
	t.Wait()
	if t.Error() != nil {
		panic(t.Error())
	}

	alive := ""
	msg := func(mq mqtt.Client, m mqtt.Message) {
		alive = string(m.Payload())
		log.Println("alive?", alive)
		send(rm, "True" == alive)
	}

	topic := "/public/p2k16-dev/label-alive/alive"
	t = mq.Subscribe(topic, 1, msg)
	t.Wait()

	for {
		if "" != alive {
			send(rm, "True" == alive)
		}
		time.Sleep(30 * time.Second)
	}
}

func send(rm riemanngo.Client, alive bool) {
	metric := 0
	state := "critical"
	if alive {
		metric = 1
		state = "ok"
	}

	result, err := riemanngo.SendEvent(rm, &riemanngo.Event{
		Service: "p2k16-label",
		Metric:  metric,
		Host:    "heim",
		State:   state,
	})
	if err != nil {
		panic(err)
	}
	log.Println("riemann result", result)
}
