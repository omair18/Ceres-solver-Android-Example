# Ceres Solver - A fast non-linear least squares minimizer
# Copyright 2015 Google Inc. All rights reserved.
# http://ceres-solver.org/

LOCAL_PATH := $(call my-dir)

LOCAL_PATH_ := /windows/D/Linux/softwares/ceres-solver/jni/

include $(CLEAR_VARS)


LOCAL_MODULE := ceres
LOCAL_SRC_FILES := /windows/D/Linux/softwares/ceres-solver/obj/local/armeabi-v7a/libceres.a
include $(PREBUILT_STATIC_LIBRARY)

LOCAL_MODULE := opencvv7
LOCAL_SRC_FILES := /windows/D/Linux/softwares/OpenCV-2.4.9-android-sdk/sdk/native/libs/armeabi-v7a/libopencv_java.so
include $(PREBUILT_SHARED_LIBRARY)

LOCAL_MODULE := opencv
LOCAL_SRC_FILES := /windows/D/Linux/softwares/OpenCV-2.4.9-android-sdk/sdk/native/libs/armeabi/libopencv_java.so
include $(PREBUILT_SHARED_LIBRARY)





# Ceres requires at least NDK version r9d to compile.
ifneq ($(shell $(LOCAL_PATH)/assert_ndk_version.sh "r9d" $(NDK_ROOT)), true)
  $(error Ceres requires NDK version r9d or greater)
endif

EIGEN_PATH := $(EIGEN_PATH)
CERES_INCLUDE_PATHS := $(CERES_EXTRA_INCLUDES)
CERES_INCLUDE_PATHS += $(LOCAL_PATH_)/../internal
CERES_INCLUDE_PATHS += $(LOCAL_PATH_)/../internal/ceres
CERES_INCLUDE_PATHS += $(LOCAL_PATH_)/../include
CERES_INCLUDE_PATHS += $(LOCAL_PATH_)/../config

# Use the alternate glog implementation if provided by the user.
ifdef CERES_GLOG_DIR
  CERES_INCLUDE_PATHS += $(CERES_GLOG_DIR)
else
  CERES_INCLUDE_PATHS += $(LOCAL_PATH_)/../internal/ceres/miniglog
endif
CERES_SRC_PATH := $(LOCAL_PATH_)../internal/ceres

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(CERES_INCLUDE_PATHS)
LOCAL_C_INCLUDES += $(EIGEN_PATH)

#LOCAL_CPP_EXTENSION := .cc
LOCAL_CFLAGS := $(CERES_EXTRA_DEFINES) \
                -DCERES_NO_LAPACK \
                -DCERES_NO_SUITESPARSE \
                -DCERES_NO_CXSPARSE \
                -DCERES_STD_UNORDERED_MAP \
		-DCERES_RESTRICT_SCHUR_SPECIALIZATION

LOCAL_C_INCLUDES += include


# If the user did not enable threads in CERES_EXTRA_DEFINES, then add
# CERES_NO_THREADS.
#
# TODO(sameeragarwal): Update comments here and in the docs to
# demonstrate how OpenMP can be used by the user.
ifeq (,$(findstring CERES_HAVE_PTHREAD, $(LOCAL_CFLAGS)))
  LOCAL_CFLAGS += -DCERES_NO_THREADS
endif

LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog -lopencv_java

include /windows/D/Linux/softwares/OpenCV-2.4.9-android-sdk/sdk/native/jni/OpenCV.mk

LOCAL_SRC_FILES := helloworld.cc \
		   $(CERES_SRC_PATH)/thread_token_provider.cc


LOCAL_STATIC_LIBRARIES := ceres
LOCAL_SHARED_LIBRARIES := opencv
LOCAL_SHARED_LIBRARIES += opencvv7

ifndef CERES_GLOG_DIR
LOCAL_SRC_FILES += $(CERES_SRC_PATH)/miniglog/glog/logging.cc
endif

LOCAL_MODULE := DfUSMC
include $(BUILD_SHARED_LIBRARY)
