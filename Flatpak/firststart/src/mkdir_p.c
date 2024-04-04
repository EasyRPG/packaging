
/* adapted from a stackoverflow answer
 * https://gist.github.com/JonathonReinhart/8c0d90191c38af2dcadb102c4e202950
 */

#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>   /* mkdir(2) */
#include <errno.h>

/* Make a directory; already existing dir okay */
static int maybe_mkdir(const char* path, mode_t mode) {
    struct stat st;
    errno = 0;

    /* Try to make the directory */
    if (mkdir(path, mode) == 0)
        return 0;

    /* If it fails for any reason but EEXIST, fail */
    if (errno != EEXIST)
        return -1;

    /* Check if the existing path is a directory */
    if (stat(path, &st) != 0)
        return -1;

    /* If not, fail with ENOTDIR */
    if (!S_ISDIR(st.st_mode)) {
        errno = ENOTDIR;
        return -1;
    }

    /* Reset error codes */
    errno = 0;
    return 0;
}

int mkdir_p(const char *path) {
    /* Adapted from http://stackoverflow.com/a/2336245/119527 */
    mode_t mode = 0777;
    errno = 0;

    /* Copy string so it's mutable */
    char *_path = strdup(path);
    if (_path == NULL || strlen(path) == 0) {
        free(_path);
        /* Empty path */
        errno = ENOENT;
        return -1;
    }

    /* Iterate the string */
    for (char *p = _path + 1; *p; p++) {
        if (*p == '/') {
            /* Temporarily truncate */
            *p = '\0';
            /* Create each directory */
            if (maybe_mkdir(_path, mode) != 0) {
                free(_path);
                return -1;
            }
            /* Revert truncation */
            *p = '/';
        }
    }

    /* Create full path */
    if (maybe_mkdir(_path, mode) != 0) {
        free(_path);
        return -1;
    }

    /* Finally done */
    free(_path);
    return 0;
}
