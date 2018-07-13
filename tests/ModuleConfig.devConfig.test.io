ioTest testSuite("ModuleConfig devConfig") \
    test(
        "sets development block for module setup",

        block(
            moduleConfigInstance := ModuleConfig clone

            developmentConfigSpy := SpyFactory build

            moduleConfigInstance devConfig(block(
                developmentConfigSpy call
            ))

            moduleConfigInstance development call

            callCount := developmentConfigSpy getCallCount
            failureMessage := "Development config spy called #{callCount} times" interpolate

            IoAssertion assertEqual(callCount, 1, failureMessage)
        )
    ) \
    test(
        "calls production block when dev block is called",

        block(
            moduleConfigInstance := ModuleConfig clone

            prodConfigSpy := SpyFactory build()

            moduleConfigInstance devConfig(block())

            moduleConfigInstance prodConfig(block(
                prodConfigSpy call
            ))

            moduleConfigInstance development call

            callCount := prodConfigSpy getCallCount
            failureMessage := "Production config spy called #{callCount} times" interpolate

            IoAssertion assertEqual(callCount, 1, failureMessage)
        )
    ) \
    test(
        "returns moduleConfig instance for chaining purposes",

        block(
            moduleConfigInstance := ModuleConfig clone

            returnedValue := moduleConfigInstance devConfig(block())

            IoAssertion assertEqual(returnedValue, moduleConfigInstance, "devConfig did not return self")
        )
    )