return {
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",

        opts = {
            default = {
                dir_path = "/home/ezraklukas/Documents/arbeit/ubckin/notes/ezra/attachments",
                file_name = "Pasted image %Y%m%d%H%M%S",
                extension = "png",

                use_absolute_path = false,
                relative_to_current_file = false,

                template = "![[%s]]",
            },
        },

        keys = {
            {
                "<leader>pi",
                "<cmd>PasteImage<cr>",
                desc = "Paste image from clipboard",
            },
        },
    },
}
