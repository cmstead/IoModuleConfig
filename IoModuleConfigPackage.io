IoModuleConfigPackage := ModuleConfig clone \
    do(
        setName("IoModuleConfig")
        setVersion("1.0.0")

        initializeModuleLoader()
    )

IoModuleConfigPackage init := method(
    prodConfig(block())

    devConfig(block(
        moduleLoader \
            addSearchPath("iotest") \
            configure()
    ))
)