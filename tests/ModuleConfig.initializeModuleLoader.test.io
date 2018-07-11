ioTest testSuite("ModuleConfig initializeModuleLoader") \
    test(
        "initializes module loader",
        block(
            Importer addSearchPath("./tests/fixtures/foo")

            moduleConfigInstance := ModuleConfig clone

            moduleConfigInstance setName("foo")

            moduleConfigInstance initializeModuleLoader()

            basePath := moduleConfigInstance moduleLoader basePath
            searchPaths := moduleConfigInstance moduleLoader searchPaths

            IoAssertion assertTrue(basePath containsSeq("foo"))
            IoAssertion assertEqual(searchPaths size(), 0)
        )
    )