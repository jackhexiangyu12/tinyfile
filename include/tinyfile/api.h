#ifndef TINYFILE_API_H
#define TINYFILE_API_H

#include "types.h"

/* API error codes */
static int TINYFILE_INIT_ERROR = 1;
static int TINYFILE_EXIT_ERROR = 2;
static int TINYFILE_CREATE_QUEUE_ERROR = 3;
static int TINYFILE_CREATE_SHM_ERROR = 4;
static int TINYFILE_DESTROY_SHM_ERROR = 5;

/* Initialize API and exit */
extern int tinyfile_init();

extern int tinyfile_exit();


/* Synchronous API */
extern int tinyfile_sync(tinyfile_arg_t *arg, tinyfile_service_t service, tinyfile_request_priority_t priority,
                         tinyfile_arg_t *out);


/* Asynchronous API */
extern int tinyfile_async(tinyfile_arg_t *arg, tinyfile_service_t service, tinyfile_request_priority_t priority,
                          tinyfile_request_key_t *key);


/* Wait for asynchronous request to complete */
extern int tinyfile_async_wait(tinyfile_request_key_t key, tinyfile_arg_t *arg);


/* Join on a group of asynchronous requests */
extern int tinyfile_async_join(tinyfile_request_key_t key, tinyfile_arg_t *arg);


/* Call a callback function on each key and argument once request is completed */
extern int
tinyfile_async_map(tinyfile_request_key_t *keys, int size, void (*fn)(tinyfile_request_key_t, tinyfile_arg_t *));

#endif //TINYFILE_API_H
