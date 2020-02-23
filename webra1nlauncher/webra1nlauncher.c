// Jus de Patate - 2020 - jusdepatate@protonmail.com (github:jusdepatate)
// This script is part of Webra1n As a Service (github:jusdepatate/webra1n-as-a-service)
// It was made to deal with Checkra1n requiring Ncurses

#include <stdio.h>
#include <stdlib.h>

int main() {
	system("/usr/bin/checkra1n --wui 0.0.0.0 80");
	return 0;
}
