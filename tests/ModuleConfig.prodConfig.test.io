ioTest testSuite("ModuleConfig prodConfig") \
    test(
        "sets production block for module setup",

        block(
            moduleConfigInstance := ModuleConfig clone

            productionConfigSpy := SpyFactory build()

            moduleConfigInstance prodConfig(block(
                productionConfigSpy call()
            ))

            moduleConfigInstance production call()

            callCount := productionConfigSpy getCallCount
            failureMessage := "Production config spy called #{callCount} times" interpolate

            IoAssertion assertEqual(callCount, 1, failureMessage)
        )
    ) \
    test(
        "sets development block for module setup",

        block(
            moduleConfigInstance := ModuleConfig clone

            productionConfigSpy := SpyFactory build()

            moduleConfigInstance prodConfig(block(
                productionConfigSpy call()
            ))

            moduleConfigInstance development call()

            callCount := productionConfigSpy getCallCount
            failureMessage := "Production config spy called #{callCount} times" interpolate

            IoAssertion assertEqual(callCount, 1, failureMessage)
        )
    ) \
    test(
        "does not set development block for module setup if one already exists",

        block(
            moduleConfigInstance := ModuleConfig clone

            devConfigSpy := SpyFactory build()

            moduleConfigInstance devConfig(block(
                devConfigSpy call()
            ))

            moduleConfigInstance prodConfig(block())

            moduleConfigInstance development call()

            callCount := devConfigSpy getCallCount
            failureMessage := "Development config spy called #{callCount} times" interpolate

            IoAssertion assertEqual(callCount, 1, failureMessage)
        )
    ) \
    test(
        "does not call development block when prod block is called",

        block(
            moduleConfigInstance := ModuleConfig clone

            devConfigSpy := SpyFactory build()

            moduleConfigInstance devConfig(block(
                devConfigSpy call()
            ))

            moduleConfigInstance prodConfig(block())

            moduleConfigInstance production call()

            callCount := devConfigSpy getCallCount
            failureMessage := "Development config spy called #{callCount} times" interpolate

            IoAssertion assertEqual(callCount, 0, failureMessage)
        )
    ) \
    test(
        "returns moduleConfig instance for chaining purposes",

        block(
            moduleConfigInstance := ModuleConfig clone

            returnedValue := moduleConfigInstance prodConfig(block())

            IoAssertion assertEqual(returnedValue, moduleConfigInstance, "prodConfig did not return self")
        )
    )