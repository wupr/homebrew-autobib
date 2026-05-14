class Autobib < Formula
  desc "Command-line tool for managing bibliographic records"
  homepage "https://github.com/autobib/autobib"
  url "https://github.com/autobib/autobib/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "4f641d455075af0baac3a67e28388eb8bcf837c5002c70959efa3a52e5681d38"
  license "AGPL-3.0-or-later"

  head "https://github.com/autobib/autobib.git", branch: "main"

  bottle do
    root_url "https://github.com/wupr/homebrew-autobib/releases/download/autobib-0.5.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bc414cfeaf8b74e10206f65c2ed44edfbac85f5a8c3fea64df608dbec8783063"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "832bedbe79bb0c885cf1b4434a96c720cc77ba846d616c7d78774e586370d4fe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "36fa562af047c558cf234a8d852b3593e75e5cd2ae20740982bda79ebd188c58"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "941ea31a6a28ed4853adf0f1abe31f80682d2fb34d2cf017c8e9253a62e8aae7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a5b32413d66c4db0d3257141f31cccc95e38d364c704ba7df3811a65f94ed40"
  end

  depends_on "cargo-about" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    doc.install "README.md", "COPYRIGHT", "LICENSE"
    if build.bottle?
      system "cargo-about", "generate",
        "--config", "about/config.toml",
        "--output-file", doc/"third-party-licenses.html",
        "about/template.hbs"
    end

    generate_completions_from_executable(bin/"autobib", "completions")
  end

  test do
    assert_equal "autobib #{version}", shell_output("#{bin}/autobib --version").strip
  end
end
