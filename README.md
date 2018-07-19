# IoModuleConfig #

A module configuration library for Io language to allow for self-contained modules to be packaged and configured.  Has a dependency on LibPath and PathUtil protos:

(Links will be put here when libraries are versioned independently.  For now, both of these protos are in this package.  Simply put them in your project and make them available in your Importer search path.)

## Setup ##

To set up your module, first add the `LibPath.io` and `PathUtil.io` files from the [IoPathUtils repository](https://github.com/cmstead/IoPathUtils) based on the instructions in the readme.

Nex, create a package file in your package root named like the following:

`<packageName>Package.io`

Finally, set up a base configuration which should look similar to the following:

```io
LibPath addPathWithBaseByDirName("<baseDirectoryName>", "libs/ModuleConfig")

<packageName>Package := ModuleConfig clone \
    do(
        setName("<packageName>")
        setVersion("1.0.0")

        initializeModuleLoader()
    )

<packageName>Package init := method(
    prodConfig(block(
        moduleLoader \
            configure()
    ))

    devConfig(block(
        moduleLoader \
            configure()
    ))
)
```

## Usage ##

At the top of your main script or proto, include the following:

```io
<packageName>Package clone production call
```

If you have a development script or test package, included, you can set up for development by doing the following instead:

```io
<packageName>Package clone development call
```

This will ensure all configuration and libraries are properly set up for your project when it runs.

## Examples ##

The IoTest package uses IoModuleConfig.  The following examples are the current configuration in IoTest:

IoTestPackage:

```io
LibPath addPathWithBaseByDirName("iotest", "libs/ModuleConfig")

IoTestPackage := ModuleConfig clone \
    do(
        setName("iotest")
        setVersion("1.0.0")

        initializeModuleLoader()
    )

IoTestPackage init := method(
    prodConfig(block(
        moduleLoader \
            addSearchPath("core") \
            addSearchPath("core/runnerCore") \
            addSearchPath("core/assertionCore") \
            addSearchPath("core/testCore") \
            configure()
    ))

    devConfig(block(

    ))
)
```

IoTest test runner:

```io
packageConfig := IoTestPackage clone
cwd := PathUtil getSearchPathByDirName(packageConfig name)

packageConfig development call

IoTestRunnerFactory \
    buildRunner() \
        setCwd(cwd) \
        setTestExtension(".test") \
        addTestPath("tests") \
        run()
```

## API ##

### ModuleConfig ###

**devConfig**

Sets the development configuration block for use later

Contract: `devConfig(devConfigBlock:Block)`

**initializeModuleLoader**

Creates a new module loader instance and performs a base configuration

Contract: `initializeModuleLoader()`

**moduleLoader**

An instance of ModuleLoader, see API below for this object

**prodConfig**

Sets the production configuration block for use later

Contract: `prodConfig(prodConfigBlock:Block)`

### ModuleLoader ###

**addSearchPath**

Adds a new search path to the list of paths to be registered with Importer.  All search paths are expected to be relative to the base path.

Contract: `addSearchPath(searchPath:string)`

**setBasePathByName**

Sets module base path based on the directory name provided.  Base path is captured from Importer search paths.

Contract: `setBasePathByName(dirName:string)`

**configure**

Configures search paths for all found libraries and other registered search paths with Importer.

Contract: `configure()`