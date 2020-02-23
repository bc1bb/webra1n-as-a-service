// Jus de Patate - 2020 - jusdepatate@protonmail.com (github:jusdepatate)
// This script is part of Webra1n As a Service (github:jusdepatate/webra1n-as-a-service)
// It was meant to run checkra1n on a user through ssh without being able to kill it unless we are root

#include <stdio.h>
#include <signal.h>
#include <stdlib.h>

void SIGhandler(int);

int main(void) {
	signal(SIGINT, SIGhandler);
	signal(SIGQUIT, SIGhandler);
	while (1)
		system("/usr/bin/checkra1n --tui");
	return 0;
}

void SIGhandler(int sig) {
	char c;
	signal(sig, SIG_IGN);
	printf("You tried");
}
