import { Octokit } from '@octokit/rest';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load config
const configPath = join(__dirname, 'config', 'config.json');
const config = JSON.parse(readFileSync(configPath, 'utf8'));

// Initialize Octokit with GitHub token
const octokit = new Octokit({
  auth: process.env.GITHUB_TOKEN || config.github.token
});

export const githubService = {
  // Get repository information
  async getRepository(owner, repo) {
    const { data } = await octokit.repos.get({ owner, repo });
    return data;
  },

  // List repositories for a user
  async listRepositories(username) {
    const { data } = await octokit.repos.listForUser({ username });
    return data;
  },

  // Get repository contents
  async getContents(owner, repo, path = '') {
    const { data } = await octokit.repos.getContent({ owner, repo, path });
    return data;
  },

  // Create a new issue
  async createIssue(owner, repo, title, body) {
    const { data } = await octokit.issues.create({
      owner,
      repo,
      title,
      body
    });
    return data;
  },

  // List issues
  async listIssues(owner, repo, state = 'open') {
    const { data } = await octokit.issues.listForRepo({
      owner,
      repo,
      state
    });
    return data;
  },

  // Get a specific issue
  async getIssue(owner, repo, issueNumber) {
    const { data } = await octokit.issues.get({
      owner,
      repo,
      issue_number: issueNumber
    });
    return data;
  },

  // Create a pull request
  async createPullRequest(owner, repo, title, body, head, base) {
    const { data } = await octokit.pulls.create({
      owner,
      repo,
      title,
      body,
      head,
      base
    });
    return data;
  },

  // List pull requests
  async listPullRequests(owner, repo, state = 'open') {
    const { data } = await octokit.pulls.list({
      owner,
      repo,
      state
    });
    return data;
  },

  // Get commits
  async listCommits(owner, repo, perPage = 10) {
    const { data } = await octokit.repos.listCommits({
      owner,
      repo,
      per_page: perPage
    });
    return data;
  },

  // Get branches
  async listBranches(owner, repo) {
    const { data } = await octokit.repos.listBranches({ owner, repo });
    return data;
  },

  // Search code
  async searchCode(query) {
    const { data } = await octokit.search.code({ q: query });
    return data;
  },

  // Get file content
  async getFileContent(owner, repo, path) {
    const { data } = await octokit.repos.getContent({ owner, repo, path });
    if (data.content) {
      return Buffer.from(data.content, 'base64').toString('utf8');
    }
    return data;
  },

  // Create or update file
  async createOrUpdateFile(owner, repo, path, message, content, sha = null) {
    const params = {
      owner,
      repo,
      path,
      message,
      content: Buffer.from(content).toString('base64')
    };
    if (sha) params.sha = sha;

    const { data } = await octokit.repos.createOrUpdateFileContents(params);
    return data;
  }
};

export default githubService;
