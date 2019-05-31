//
//  KKExceptionHandler.c
//  Swift_Demo
//
//  Created by sumian on 2019/3/28.
//  Copyright © 2019 Jerry. All rights reserved.
//

#include "KKExceptionHandler.h"

#include <stdio.h>
#include <mach-o/dyld.h>
#include <string.h>
#include <stdlib.h>

//MARK: - 获取偏移量地址
long  calculateAddress(void){
    long slide = 0;
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        if (_dyld_get_image_header(i)->filetype == MH_EXECUTE) {
            slide = _dyld_get_image_vmaddr_slide(i);
            break;
        }
    }
    return slide;
}
