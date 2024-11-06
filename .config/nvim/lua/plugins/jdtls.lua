return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    require("jdtls").start_or_attach({
      cmd = { "jdtls" },
      root_dir = require("jdtls.setup").find_root({ "gradle.build", "pom.xml", ".gradlew" }),
      on_attach = require("lsp").on_attach,
      capabilities = require("lsp").capabilities,
    })
  end,
}
