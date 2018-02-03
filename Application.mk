# Ceres Solver - A fast non-linear least squares minimizer
# Copyright 2015 Google Inc. All rights reserved.
# http://ceres-solver.org/

APP_BUILD_SCRIPT := $(call my-dir)/Android.mk
APP_PROJECT_PATH := $(call my-dir)

APP_CPPFLAGS += -fno-exceptions
APP_CPPFLAGS += -fno-rtti
APP_CPPFLAGS += -std=c++11
APP_OPTIM := release

# Use libc++ from LLVM. It is a modern BSD licensed implementation of
# the standard C++ library.
#APP_STL := c++_static
APP_STL := gnustl_static
APP_ABI := armeabi-v7a armeabi
