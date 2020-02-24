// Jus de Patate - 2020 - jusdepatate@protonmail.com (github:jusdepatate)
// This script is part of Webra1n As a Service (github:jusdepatate/webra1n-as-a-service)
// It was meant to run checkra1n on a user through ssh without being able to kill it unless we are root

#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <unistd.h>

void SIGhandler(int);

int main(void) {
	signal(SIGINT, SIGhandler);
	signal(SIGQUIT, SIGhandler);

    struct winsize w;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);

    while (1) {
        if (( w.ws_col <= 80 || w.ws_row <= 24)) {
            // if terminal size is less than 80x24 (minimum required by checkra1n), use it in CLI mode instead of TUI
            fprintf(stderr, "\033[0;31mYour terminal is too small to start checkra1n in TUI mode, using CLI mode instead.\033[0m\nYou can resize and use CTRL+C to use TUI mode\n");
            system("/usr/bin/checkra1n --cli");

        } else {
            system("/usr/bin/checkra1n --tui");
        }
    }
	return 0;
}

void SIGhandler(int sig) {
	char c;
	signal(sig, SIG_IGN);
	printf("You tried");
}
