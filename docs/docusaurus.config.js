// @ts-check
const { themes: prismThemes } = require('prism-react-renderer');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'c4-skills',
  tagline: 'Teach any AI agent to be a software architect',
  favicon: 'img/favicon.ico',
  url: 'https://muthub-ai.github.io',
  baseUrl: '/c4-skills/',
  organizationName: 'muthub-ai',
  projectName: 'c4-skills',
  onBrokenLinks: 'warn',
  onBrokenMarkdownLinks: 'warn',
  i18n: { defaultLocale: 'en', locales: ['en'] },
  markdown: { mermaid: true },
  themes: ['@docusaurus/theme-mermaid'],

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          editUrl: 'https://github.com/muthub-ai/c4-skills/tree/main/website/',
        },
        blog: false,
        theme: { customCss: require.resolve('./src/css/custom.css') },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      colorMode: { defaultMode: 'dark', disableSwitch: false },
      image: 'img/social-card.png',
      navbar: {
        title: 'c4-skills',
        logo: { alt: 'c4-skills', src: 'img/logo.svg' },
        items: [
          { type: 'docSidebar', sidebarId: 'mainSidebar', position: 'left', label: 'Docs' },
          { to: '/docs/examples/banking-system', label: 'Examples', position: 'left' },
          { to: '/docs/troubleshooting/mermaid-errors', label: 'Troubleshooting', position: 'left' },
          { href: 'https://github.com/muthub-ai/c4-skills', label: 'GitHub', position: 'right' },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Getting Started',
            items: [
              { label: 'Installation', to: '/docs/getting-started/installation' },
              { label: 'First Diagram', to: '/docs/getting-started/first-diagram' },
            ],
          },
          {
            title: 'Skills',
            items: [
              { label: 'c4designer', to: '/docs/skills/c4designer' },
              { label: 'adr-scribe', to: '/docs/skills/adr-scribe' },
            ],
          },
          {
            title: 'Reference',
            items: [
              { label: 'Mermaid C4 Syntax', to: '/docs/reference/mermaid-c4-syntax' },
              { label: 'Troubleshooting', to: '/docs/troubleshooting/mermaid-errors' },
              { label: 'CHANGELOG', href: 'https://github.com/muthub-ai/c4-skills/blob/main/CHANGELOG.md' },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Muthu B. Built with Docusaurus.`,
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
        additionalLanguages: ['bash', 'yaml', 'json'],
      },
      mermaid: {
        theme: { light: 'default', dark: 'dark' },
      },
    }),
};

module.exports = config;
