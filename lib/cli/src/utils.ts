import * as path from 'path';

import { InstrumentMetadataConfig } from './config';

export interface IWorkingProjectInfo {
  name: string;
  path: string;
}

export function findWorkingProject(): IWorkingProjectInfo {
  const cwd = process.cwd();
  const dirs = cwd.split(path.sep).reverse();
  let projectPath = cwd;
  let name;

  for (const dir of dirs) {
    if (InstrumentMetadataConfig.supportedProjects.includes(dir)) {
      name = dir;
      break;
    }

    projectPath = path.resolve(projectPath, '..');
  }

  return name
    ? {
        name,
        path: projectPath,
      }
    : null;
}
