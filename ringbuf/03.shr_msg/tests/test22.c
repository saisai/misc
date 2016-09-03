#include <stdio.h>
#include <unistd.h>
#include "shr_ring.h"

char *ring = "test.ring";

int main() {
 struct shr *s=NULL;
 int rc = -1;

 unlink(ring);

 printf("init\n");
 if (shr_init(ring, 1024, 0) < 0) goto done;

 printf("re-init, overwrite\n");
 if (shr_init(ring, 1024, SHR_INIT_OVERWRITE) < 0) goto done;

 printf("re-init, keep existing\n");
 if (shr_init(ring, 1024, SHR_INIT_KEEPEXIST) < 0) goto done;

 printf("ok\n");

 rc = 0;

done:
 if (s) shr_close(s);
 return rc;
}
