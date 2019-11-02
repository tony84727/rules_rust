# def _impl(repository_ctx):


# cargo_raze_toml = repository_rule(
#     implementation = _impl,
# )
cargo_raze_toml = rule(
    implementation = _impl,
    attrs = {
        "src": attr.label(allow_single_file = True, mandatory = True),
        "out": attr.output(mandatory = True),
        "genmode": attr.string(default = "Remote"),
        "workspace": attr.string(mandatory = True),
    },
)

def _impl(ctx):
    ctx.actions.run_shell(
        inputs = [ctx.file],
        outputs = [ctx.outputs.out],
        command = """
        cp $< $@ && echo < "[raze]
genmode = "%s"
target = "%s"
workspace = "%s"
        """ % (
            ctx.attr.genmode,
            ctx.attr.target,
            ctx.attr.workspace,
        )
    )