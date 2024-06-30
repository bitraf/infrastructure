package main

import (
	"fmt"
	"log"
	"time"

	snmp "github.com/gosnmp/gosnmp"
	"github.com/riemann/riemann-go-client"
)

func main() {
	addr_riemann := "riemann.bitraf.no:5555"
	addr_printer := "etikett2.lan.bitraf.no"

	rm := riemanngo.NewTCPClient(addr_riemann, 5*time.Second)
	err := rm.Connect()
	if err != nil {
		panic(err)
	}

	snmp.Default.Target = addr_printer
	snmp.Default.Version = snmp.Version1
	err = snmp.Default.Connect()
	if err != nil {
		panic(err)
	}
	defer snmp.Default.Conn.Close()

	for {
		oids := []string{"1.3.6.1.2.1.1.3.0", "1.3.6.1.2.1.43.10.2.1.4.1.1"}
		result, err := snmp.Default.Get(oids)
		if err != nil {
			panic(err)
		}

		uptime := snmp.ToBigInt(result.Variables[0].Value).Int64()
		total_page_count := snmp.ToBigInt(result.Variables[1].Value).Int64()

		send(rm, uptime, total_page_count)

		time.Sleep(13 * time.Second)
	}
}

func send(rm riemanngo.Client, uptime int64, total_page_count int64) {
	uptime_f64 := 0.01 * float64(uptime)
	uptime_days := uptime_f64 / 86400.0
	result, err := riemanngo.SendEvent(rm, &riemanngo.Event{
		Service:     "uptime",
		Metric:      uptime_f64,
		Description: fmt.Sprintf("%.1f days", uptime_days),
		Host:        "etikett2",
		State:       "ok",
	})
	if err != nil {
		panic(err)
	}

	log.Println("riemann result", result)
	result, err = riemanngo.SendEvent(rm, &riemanngo.Event{
		Service: "total_page_count",
		Metric:  total_page_count,
		Host:    "etikett2",
		State:   "ok",
	})
	if err != nil {
		panic(err)
	}
	log.Println("riemann result", result)
}
