//
//  kernel.c
//  Sean16CPU
//
//  Created by Frida Boleslawska on 26.09.24.
//

#include "../../Sean16.h"
#include "bootloader.h"
#import <GPU/gpu.h>
#import <Peripherals/Mouse/Mouse.h>
#import <VFS/fs.h>

extern void *execute(void *arg);

void bootloader(uint16_t binmap[1000][6]) {
    // clear my screen
    clearScreen();

    if(!fs_check()) {
        #if debug
        printf("[soc-bootloader-chip] initialising block device\n");
        #endif
        fs_init();
        #if debug
        printf("[soc-bootloader-chip] formating block device\n");
        #endif
        fs_format();
        #if debug
        printf("[soc-bootloader-chip] creating test file\n");
        #endif
        fs_cfile("test.txt", "Hello, Sean16");
        #if debug
        printf("[soc-bootloader-chip] received file content: %s\n", fs_rfile("test.txt"));
        #endif
        fs_dfile("test.txt");
    } else {
        #if debug
        printf("[soc-bootloader-chip] block device is already initialised\n");
        #endif
    }
    
    // INIT
    #if debug
    printf("[soc-bootloader-chip] initialising mouse\n");
    #endif
    TouchTracker *mouse = getTracker(NULL);
    [mouse startTracking];
    
    // fork process
    #if debug
    printf("[soc-bootloader-chip] forking kernel process\n");
    #endif
    proc *child_task = proc_fork(binmap);
    if(child_task == NULL) {
        #if debug
        printf("[soc-bootloader-chip] forking process failed\n");
        #endif
        return;
    }
    
    // peripherials mapping
    #if debug
    printf("[soc-bootloader-chip] mapping peripherals\n");
    #endif
    *((CGPoint **)&child_task->page[2]->memory[0][0]) = [mouse getPos];
    *((NSInteger **)&child_task->page[2]->memory[0][1]) = [mouse getBtn];
    
    // executing process
    #if debug
    printf("[soc-bootloader-chip] executing kernel process\n");
    #endif
    execute((void*)child_task);

    // DEINIT
    #if debug
    printf("[soc-bootloader-chip] process has finished execution\n");
    printf("[soc-bootloader-chip] deinitialising mouse\n");
    #endif
    [mouse stopTracking];

    // killing task
    #if debug
    printf("[soc-bootloader-chip] freeing process\n");
    #endif
    proc_kill(child_task);
}
