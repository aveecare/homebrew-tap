# Rendered by packaging/homebrew/build.sh in github.com/aveecare/aveecare-cli;
# edit aveecare.rb.in there, not this file.
class Aveecare < Formula
  desc "Command-line tool for the AveeCare home care API"
  homepage "https://www.aveecare.com/docs/api"
  url "https://github.com/aveecare/aveecare-cli/releases/download/v0.1.0/aveecare-cli-0.1.0.tar.gz"
  sha256 "11f42821add6d48274af14bee164fe803575ab0ea601eb3bef2dbccaaf8aa698"
  license "MIT"

  depends_on "node"

  def install
    # Homebrew points the #!/usr/bin/env node line at its own node on install.
    libexec.install "aveecare.cjs"
    bin.install_symlink libexec/"aveecare.cjs" => "aveecare"
    man1.install "aveecare.1"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/aveecare --version").strip
    ENV.delete "AVEECARE_API_KEY"
    assert_match "No API key", shell_output("#{bin}/aveecare patients list 2>&1", 2)
  end
end
