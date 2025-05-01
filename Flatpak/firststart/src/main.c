/* EasyRPG flatpak firststart wizard
 *
 * (c) carstene1ns, 2024 - under ISC license
 */

// includes

#include <gtk/gtk.h>
#include <unistd.h>
#include "mkdir_p.h"

// globals

static GtkAssistant *assistant;
static gboolean want_save = FALSE;

static const char *prelude = "# Flatpak specific startup file created by firststart wizard\n\n";
static const char *postlude = "\n# End of startup file\n";

// signal handlers

void on_dirchooser_file_set() {
	gtk_assistant_set_page_complete(assistant,
		gtk_assistant_get_nth_page(assistant, 1), TRUE);
}

void on_quit() {
	gtk_main_quit();
}

void on_apply() {
	want_save = TRUE;
}

void on_cancel() {
	on_quit();
}

// main

int main(int argc, char* argv[]) {
	gtk_init(&argc, &argv);

	GtkBuilder* builder = gtk_builder_new_from_resource(RES_PREFIX "ui/assistant.glade");
	assistant = GTK_ASSISTANT(gtk_builder_get_object(builder, "assistant"));
	GtkFileChooser *dirchooser = GTK_FILE_CHOOSER(gtk_builder_get_object(builder, "dirchooser"));
	gtk_builder_connect_signals(builder, NULL);
	g_object_unref(builder);

	// get var set by startup script
	const char *dir = getenv("RPG_GAME_PATH");
	if(dir != NULL) {
		gtk_file_chooser_set_current_folder(dirchooser, dir);
		on_dirchooser_file_set();
	}

	gtk_widget_show(GTK_WIDGET(assistant));
	gtk_main();

	if(want_save) {
		char config_home[100];
		const char* tmp = getenv("XDG_CONFIG_HOME");
		if(tmp == NULL) {
			// non-flatpak fallback
			tmp = getenv("HOME");
			sprintf(config_home, "%s/%s", tmp, ".config");
		} else {
			strcpy(config_home, tmp);
		}
		char directory[120];
		sprintf(directory, "%s/%s", config_home, "EasyRPG/Player");
		mkdir_p(directory);

		char filename[140];
		sprintf(filename, "%s/%s", directory, "flatpak.sh");
		printf("Saving to: %s\n", filename);
		FILE *file = fopen(filename, "w");
		fputs(prelude, file);

		// only option for now
		char *startupdir = gtk_file_chooser_get_filename(dirchooser);
		if(startupdir != NULL) {
			fputs("# Startup directory (for game browser)\n", file);
			fprintf(file, "RPG_GAME_PATH=\"%s\"\n", startupdir);
			g_free(startupdir);
		}

		fputs(postlude, file);
		fclose(file);
	}

	return 0;
}
