return {
  "Civitasv/cmake-tools.nvim",
  opts = {
    cmake_build_directory = "build/${variant:buildType}",
    cmake_executor = {
      name = "quickfix",
      opts = {
        auto_close_when_success = false
      }
    },
    cmake_runner = {
      name = "quickfix",
      opts = {
        auto_close_when_success = false
      }
    }
  },
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  event = "FileType cpp,c"
}
