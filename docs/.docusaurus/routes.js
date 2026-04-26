import React from 'react';
import ComponentCreator from '@docusaurus/ComponentCreator';

export default [
  {
    path: '/c4-skills/docs',
    component: ComponentCreator('/c4-skills/docs', 'b3d'),
    routes: [
      {
        path: '/c4-skills/docs',
        component: ComponentCreator('/c4-skills/docs', 'd56'),
        routes: [
          {
            path: '/c4-skills/docs',
            component: ComponentCreator('/c4-skills/docs', '2f5'),
            routes: [
              {
                path: '/c4-skills/docs/',
                component: ComponentCreator('/c4-skills/docs/', '4fd'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/contributing/',
                component: ComponentCreator('/c4-skills/docs/contributing/', '023'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/contributing/behavioral-tests',
                component: ComponentCreator('/c4-skills/docs/contributing/behavioral-tests', '557'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/contributing/new-skill',
                component: ComponentCreator('/c4-skills/docs/contributing/new-skill', '4a1'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/examples/adr-postgresql',
                component: ComponentCreator('/c4-skills/docs/examples/adr-postgresql', 'f9d'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/examples/banking-system',
                component: ComponentCreator('/c4-skills/docs/examples/banking-system', '710'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/getting-started/first-diagram',
                component: ComponentCreator('/c4-skills/docs/getting-started/first-diagram', '325'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/getting-started/installation',
                component: ComponentCreator('/c4-skills/docs/getting-started/installation', '0d6'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/adr-scribe/',
                component: ComponentCreator('/c4-skills/docs/skills/adr-scribe/', 'bfb'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/adr-scribe/mode-interview',
                component: ComponentCreator('/c4-skills/docs/skills/adr-scribe/mode-interview', 'da5'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/adr-scribe/mode-retro-document',
                component: ComponentCreator('/c4-skills/docs/skills/adr-scribe/mode-retro-document', 'a26'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/adr-scribe/mode-review',
                component: ComponentCreator('/c4-skills/docs/skills/adr-scribe/mode-review', 'f98'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/c4designer/',
                component: ComponentCreator('/c4-skills/docs/skills/c4designer/', '2bd'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/c4designer/mode-design',
                component: ComponentCreator('/c4-skills/docs/skills/c4designer/mode-design', '0b0'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/c4designer/mode-document-code',
                component: ComponentCreator('/c4-skills/docs/skills/c4designer/mode-document-code', 'f98'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/c4designer/mode-document-prose',
                component: ComponentCreator('/c4-skills/docs/skills/c4designer/mode-document-prose', '43a'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/c4designer/mode-review',
                component: ComponentCreator('/c4-skills/docs/skills/c4designer/mode-review', '7c0'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/skills/c4designer/mode-update',
                component: ComponentCreator('/c4-skills/docs/skills/c4designer/mode-update', '9b0'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/troubleshooting/agent-issues',
                component: ComponentCreator('/c4-skills/docs/troubleshooting/agent-issues', '798'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/troubleshooting/mermaid-errors',
                component: ComponentCreator('/c4-skills/docs/troubleshooting/mermaid-errors', '4cb'),
                exact: true,
                sidebar: "mainSidebar"
              },
              {
                path: '/c4-skills/docs/troubleshooting/validator-errors',
                component: ComponentCreator('/c4-skills/docs/troubleshooting/validator-errors', '8b3'),
                exact: true,
                sidebar: "mainSidebar"
              }
            ]
          }
        ]
      }
    ]
  },
  {
    path: '*',
    component: ComponentCreator('*'),
  },
];
