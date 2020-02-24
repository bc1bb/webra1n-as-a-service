// Jus de Patate - 2020 - jusdepatate@protonmail.com (github:jusdepatate)
// This shit is part of Webra1n As a Service (github:jusdepatate/webra1n-as-a-service)
// It was made to deal with Checkra1n requiring Ncurses and sending wrong status code

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc > 1) {
        // if there are at least 1 argument

        char *PORT = "--port";
        char *P = "-p";
        char *arg1 = argv[1];

        int arg2 = 65536;

        char command[100];

        if ((strcmp(arg1, PORT) == 0 || strcmp(arg1, P) == 0)) {
            // if argument is "--port" or "-p" (strange way to do but fml took me a whole day to figure out.)

            if (argc >= 3) {
                arg2 = atoi(argv[2]);
            }
            // if there is a port specified, use it

            if ((arg2 >= 1 && arg2 <= 65535)) {
            	// checking if specified port is correct
                sprintf(command, "/usr/bin/checkra1n --wui 0.0.0.0 %d", arg2);
            	system(command);
            } else {
                fprintf(stderr, "\033[0;31mSpecified port is invalid.\033[0m\n");
            }
        } else {
            	printf("Webra1n Launcher - Jus de Patate - 2020\n\n");
            	printf("Accepted arguments:\n");
            	printf("-p [1-65535] | select a port for webra1n between 1 and 65535\n");
            	return 0;
        }

	} else {
		system("/usr/bin/checkra1n --wui 0.0.0.0 80");
	}

	return 0;
}
