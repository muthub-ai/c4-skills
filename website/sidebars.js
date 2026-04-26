/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  mainSidebar: [
    'intro',
    {
      type: 'category',
      label: '🚀 Getting Started',
      collapsed: false,
      items: [
        'getting-started/installation',
        'getting-started/first-diagram',
      ],
    },
    {
      type: 'category',
      label: '🧠 Skills',
      collapsed: false,
      items: [
        {
          type: 'category',
          label: 'c4designer',
          link: { type: 'doc', id: 'skills/c4designer/index' },
          items: [
            'skills/c4designer/mode-design',
            'skills/c4designer/mode-document-code',
            'skills/c4designer/mode-document-prose',
            'skills/c4designer/mode-review',
            'skills/c4designer/mode-update',
          ],
        },
        {
          type: 'category',
          label: 'adr-scribe',
          link: { type: 'doc', id: 'skills/adr-scribe/index' },
          items: [
            'skills/adr-scribe/mode-interview',
            'skills/adr-scribe/mode-retro-document',
            'skills/adr-scribe/mode-review',
          ],
        },
      ],
    },
    {
      type: 'category',
      label: '📐 Examples',
      items: [
        'examples/banking-system',
        'examples/adr-postgresql',
        'examples/complex-microservices',
      ],
    },
    {
      type: 'category',
      label: '📚 Reference',
      items: [
        'reference/mermaid-c4-syntax',
        'reference/notation-rules',
        'reference/adr-template',
      ],
    },
    {
      type: 'category',
      label: '🔧 Troubleshooting',
      items: [
        'troubleshooting/mermaid-errors',
        'troubleshooting/validator-errors',
        'troubleshooting/agent-issues',
      ],
    },
    {
      type: 'category',
      label: '🤝 Contributing',
      items: [
        'contributing/index',
        'contributing/new-skill',
        'contributing/behavioral-tests',
      ],
    },
  ],
};

module.exports = sidebars;
