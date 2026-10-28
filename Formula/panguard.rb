class Panguard < Formula
  desc "Security platform for AI agents - scan, audit, and protect AI skills"
  homepage "https://panguard.ai"
  version "1.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-darwin-arm64.tar.gz"
      sha256 "289cac85694a44407f3541d8071fba4edbfbf5459180c443b629c1177b8da108"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-linux-arm64.tar.gz"
      sha256 "692bb2d5fc8ec7b1a7c2ef7abed8610fe05f2bdfd6d76d953a8e0482d31760ba"
    end
    on_intel do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-linux-x64.tar.gz"
      sha256 "eb5370b2d887db4b8045922f5fe45b195b1346b042f679a1b40a1ab3859d6aec"
    end
  end

  depends_on "node@22"

  def install
    libexec.install Dir["*"]
    # Write wrapper scripts that resolve the real path (not symlink)
    (bin/"panguard").write <<~BASH
      #!/usr/bin/env bash
      exec node "#{libexec}/dist/cli/index.js" "$@"
    BASH
    (bin/"pga").write <<~BASH
      #!/usr/bin/env bash
      exec node "#{libexec}/dist/cli/index.js" "$@"
    BASH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/panguard --version")
  end
end
