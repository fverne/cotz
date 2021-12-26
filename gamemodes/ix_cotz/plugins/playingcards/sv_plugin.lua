ix.log.AddType("cardLog", function(client, ...)
    local arg = {...}

    if (arg[2] and #arg[2] > 0) then
        return L("%s %s %s.", client:Name(), arg[1], arg[2])
    else
        return L("%s %s.", client:Name(), arg[1])
    end
end)
