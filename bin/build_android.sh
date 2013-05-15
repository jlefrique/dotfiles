#!/bin/sh

android update project --path . --target android-10 --subprojects
ant debug
