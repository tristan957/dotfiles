package main

import (
	"bufio"
	"log"
	"os"
)

func main() {
	if ifile, err := os.Open(os.Args[1]); err == nil {
		var packages []string

		scanner := bufio.NewScanner(ifile)
		for scanner.Scan() {
			packages = append(packages, scanner.Text())
		}
		ifile.Close()

		sort(packages)
		createFile(packages)
	} else {
		log.Fatal(err)
	}
}

func sort(packages []string) {
	for i := 0; i < len(packages); i++ {
		for j := 0; j < len(packages); j++ {
			if packages[i] < packages[j] {
				packages[i], packages[j] = packages[j], packages[i]
			}
		}
	}
}

func createFile(packages []string) {
	if ofile, err := os.Create("solus-packages-list.txt"); err == nil {
		for i := 0; i < len(packages); i++ {
			ofile.WriteString(packages[i] + "\n")
		}
	} else {
		log.Fatal(err)
	}
}
