# Ceres-solver-Android-NDK-Example
An example for compiling ceres-solver helloworld.cc with Android NDK including OpenCV(2.4.9)
Clone Ceres-solver first. 

    git clone https://ceres-solver.googlesource.com/ceres-solver
    cd ceres-solver/jni
    
Use NDK 9+ to compile ceres-solver.
If you are trying to use OpenCV-2.4.9 in your Android project then make following changes before compiling ceres-solver. 

1. In jni/Application.mk

    APP_BUILD_SCRIPT := $(call my-dir)/Android.mk
    
    APP_PROJECT_PATH := $(call my-dir)
    
    APP_CPPFLAGS += -fno-exceptions
    
    APP_CPPFLAGS += -fno-rtti
    
    APP_CPPFLAGS += -std=c++11
    
    APP_OPTIM := release
    
    APP_STL := gnustl_static
    
    APP_ABI := armeabi-v7a armeabi

Now compile ceres-solver using #ndk-build. Once done, you will find objs created in ../obj/local/armeabi/libceres.a

Now go to your Android project and paste these Android.mk & Application.mk files inside the jni folder. 

Update the paths of libceres.a & libopencv_java.so inside Android.mk.

