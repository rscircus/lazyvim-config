-- Playful, low-stakes plugins. All lazy-loaded; none cost anything at idle.
return {
  -- A duck (or cat/crab) waddles across the buffer. Pure joy, no autoload.
  {
    "tamton-aquib/duck.nvim",
    keys = {
      { "<leader>ud", function() require("duck").hatch("🦆", 5) end, desc = "Hatch a duck" },
      { "<leader>uD", function() require("duck").cook() end, desc = "Cook the duck" },
    },
  },

  -- When the tests break and you need a moment: melt the code into rain.
  {
    "Eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain" },
    },
  },

  -- Coding stats: XP, levels, activity heatmap, per-language breakdown.
  -- Built by/for ADHD coders. Lean on the XP/heatmap; the streak counter is
  -- optional dopamine, not a stick — cumulative beats consecutive.
  {
    "gisketch/triforce.nvim",
    dependencies = { "nvzone/volt" },
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>tp", "<cmd>Triforce profile<cr>", desc = "Coding stats (Triforce)" },
    },
  },
}
