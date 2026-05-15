class Autobib < Formula
  desc "Command-line tool for managing bibliographic records"
  homepage "https://github.com/autobib/autobib"
  url "https://github.com/autobib/autobib/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "859432b9591c8d63cc047aaddc214c1c9f93047ba1ba327ac5ce22f62bc8b75e"
  license "AGPL-3.0-or-later"

  head "https://github.com/autobib/autobib.git", branch: "main"

  bottle do
    root_url "https://github.com/wupr/homebrew-autobib/releases/download/autobib-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e061ebaf86e28020b0c0980ced7d4038b1b09b9b23eb07d8b1aad2cfef4e18b3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "39e218480339f848f9a8c6e93b91d66186735ed5bec3a7041443f89da1021693"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2d01b904b5a7b06ef162bff9a61c203eec4756f6b75cb9484457f0f10c6ab59d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a9e56c0e20b53ba378fe01169c11b4ab9c64d23b6cb394ba69afc352641aa11a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e43faa6a5c72742dea8d4550562daa9280bc4a1aee432a27b7aec8c1c8b1b7a5"
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
