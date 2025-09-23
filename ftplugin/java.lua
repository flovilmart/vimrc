local home = os.getenv('HOME')
local jdtls = require('jdtls')
local jdtls_home = '/opt/homebrew/Cellar/jdtls/1.29.0/libexec/'

local lsp_common = require('lsp_common')
-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Helper function for creating keymaps
function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
  lsp_common.on_attach(client, bufnr)
  -- Java extensions provided by jdtls
  -- bufopts = { noremap=true, silent=true, buffer=bufnr, desc = "" }
  -- -- nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  -- nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  -- nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  -- vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
  --     { noremap=true, silent=true, buffer=bufnr, desc = "Extract method" })
end

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  on_attach = on_attach,  -- We pass our on_attach keybindings to the configuration map
  root_dir = root_dir, -- Set the root directory to our found root_marker
  -- Here you can configure eclipse.jdt.ls specific settings
  -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      -- format = {
      --   settings = {
      --     -- Use Google Java style guidelines for formatting
      --     -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
      --     -- and place it in the ~/.local/share/eclipse directory
      --     url = "/.local/share/eclipse/eclipse-java-google-style.xml",
      --     profile = "GoogleStyle",
      --   },
      -- },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
      -- Specify any completion options
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*", "sun.*",
        },
      },
      -- Specify any options for organizing imports
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      -- How code generation should act
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      -- If you are developing in projects with different Java versions, you need
      -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- And search for `interface RuntimeOption`
      -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
      configuration = {
        runtimes = {
          {
            name = "JavaSE-19",
            path = os.getenv("JAVA_19_HOME") .. "/bin/java",
          },
          {
            name = "JavaSE-21",
            path = os.getenv("JAVA_21_HOME") .. "/bin/java",
          },
          {
            name = "JavaSE-22",
            path = "/Library/Java/JavaVirtualMachines/amazon-corretto-22.jdk/Contents/Home/bin/java"
          }
        }
      }
    }
  },
  -- cmd is the command that starts the language server. Whatever is placed
  -- here is what is passed to the command line to execute jdtls.
  -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  -- for the full list of options
  cmd = {
    '/opt/homebrew/bin/jdtls',
    --  java_home .. "/bin/java",
    --  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    --  '-Dosgi.bundles.defaultStartLevel=4',
    --  '-Declipse.product=org.eclipse.jdt.ls.core.product',
    --  '-Dlog.protocol=true',
    --  '-Dlog.level=ALL',
    --  '-Xmx4g',
    --  '--add-modules=ALL-SYSTEM',
    --  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    --  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    --  -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
   '--jvm-arg=-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',


    --  -- The jar file is located where jdtls was installed. This will need to be updated
    --  -- to the location where you installed jdtls
    --  '-jar', vim.fn.glob(jdtls_home .. 'plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar'),

    --  -- The configuration for jdtls is also placed where jdtls was installed. This will
    --  -- need to be updated depending on your environment
    --  '-configuration', jdtls_home .. 'config_mac',

    --  -- Use the workspace_folder defined above to store data for this project
    --  '-data', workspace_folder,
    '-data' .. workspace_folder,
  },
}
-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
jdtls.start_or_attach(config)
