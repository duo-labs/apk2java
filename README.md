# apk2java

`apk2java` is a Docker image that lets you decompile an APK to Java in a single step.

This image is based on the [cryptax/androidre](https://github.com/cryptax/androidre) image. We've removed tools we didn't need and adjusted the image to focus on only extracting resources and decompiling the APK.

## Using the Container

`apk2java` expects a volume to be mounted at `/apk`. To use the image, simply change into the directory containing `yourapk.apk` and run `docker run -v $(pwd):/apk duo-labs/apk2java /apk/yourapk.apk`.

If successful, you will see two directories created: "yourapk.apk.files" (the resources) and "yourapk.apk.src" (the decompiled Java source code). 