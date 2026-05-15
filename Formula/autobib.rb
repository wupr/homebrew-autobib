class Autobib < Formula
  desc "Command-line tool for managing bibliographic records"
  homepage "https://github.com/autobib/autobib"
  url "https://github.com/autobib/autobib/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "859432b9591c8d63cc047aaddc214c1c9f93047ba1ba327ac5ce22f62bc8b75e"
  license "AGPL-3.0-or-later"

  head "https://github.com/autobib/autobib.git", branch: "main"

  bottle do
    root_url "https://github.com/wupr/homebrew-autobib/releases/download/autobib-0.6.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5f670d8a1647f861eef0c744d0c2f9f3f30a5bc050969109e445a94bbabad6e5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7f23638dbd609e151c335481bf97811b623f4f2bc8b5f43b678ee016b44bef1b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0a851e68445cdea873a4191b55ca6bf3b336b8b7c051fd31c128451d7c171ee1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a440dc611c7b4afc84e3be96db713f3e0a6e0219a8a6a5a60817d8a6aa135577"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46e4c2a5bf3e15ce31c20467a806629991dc64c4bc73615d6f41b8791afcc554"
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
