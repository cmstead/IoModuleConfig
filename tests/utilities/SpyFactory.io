SpyFactory := Object clone

SpyFactory build := method(
    executableBlock,

    callCount := 0

    spy := block(
        callCount = callCount + 1

        if(
            executableBlock != nil,
            executableBlock call()
        )
    )

    spy getCallCount := block(
        return callCount
    )

    return spy
)