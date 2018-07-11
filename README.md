# IoModuleConfig #

A module configuration library for Io language to allow for self-contained modules to be packaged and configured.  Has a dependency on LibPath and PathUtil protos:

(Links will be put here when libraries are versioned independently.  For now, both of these protos are in this package.  Simply put them in your project and make them available in your Importer search path.)

An example of usage as pulled from IoTest:

~~~io
LibPath addPathWithBaseByDirName("iotest", "libs/ModuleConfig")

PackageConfig := ModuleConfig clone \
    do(
        setName("iotest")
        setVersion("1.0.0")

        initializeModuleLoader()
    )

PackageConfig init := method(
    prodConfig(block(
        moduleLoader \
            addSearchPath("core") \
            addSearchPath("core/runnerCore") \
            addSearchPath("core/assertionCore") \
            addSearchPath("core/testCore") \
            configure()
    ))

    devConfig(block(
        // Configuration logic goes here
    ))
)
~~~