package main

import (
	"log"
	"os"
	"os/exec"
	"time"

	"github.com/riemann/riemann-go-client"
)

func main() {
	host, err := os.Hostname()
	if err != nil {
		panic(err)
	}

	addr_riemann := "riemann.bitraf.no:5555"

	rm := riemanngo.NewTCPClient(addr_riemann, 5*time.Second)
	err = rm.Connect()
	if err != nil {
		panic(err)
	}
	log.Printf("Connected to Riemann server %s", addr_riemann)

	for {
		running, err := exec.Command("systemctl", "is-system-running").Output()
		ok := err == nil
		description := string(running)

		if !ok {
			failed, err := exec.Command("systemctl", "list-units", "--failed").Output()
			if err != nil {
				log.Print(err)
			} else {
				description += "\n" + string(failed)
			}
		}

		send(rm, host, ok, description)

		time.Sleep(3 * time.Second)
	}
}

func send(rm riemanngo.Client, host string, ok bool, description string) {
	state := "critical"
	if ok {
		state = "ok"
	}
	_, err := riemanngo.SendEvent(rm, &riemanngo.Event{
		Service:     "system",
		Description: description,
		Host:        host,
		State:       state,
	})
	if err != nil {
		panic(err)
	}
}
