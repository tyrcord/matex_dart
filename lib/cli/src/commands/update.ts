import { logger } from '@tutils/logger';
import axios from 'axios';
import { promises as fs } from 'fs';
import * as path from 'path';

import { IFileMetadata, InstrumentMetadataConfig } from '../config';
import { findWorkingProject, IWorkingProjectInfo } from '../utils';

async function* asyncCombineFileGenerator(projectInfo: IWorkingProjectInfo) {
  const { filesToCombine } = InstrumentMetadataConfig;

  for (const fileMeta of filesToCombine) {
    yield combineFile(projectInfo, fileMeta);
  }
}

export async function update(): Promise<void> {
  const projectInfo = findWorkingProject();

  if (projectInfo) {
    try {
      // @ts-ignore
      for await (const _ of asyncCombineFileGenerator(projectInfo)) {
        // @ts-ignore
      }

      logger.success('Matex meta files have been updated!');
    } catch (error) {
      logger.error(error);
    }
  } else {
    logger.error('Please run this command in a Matex project!');
  }
}

async function combineFile(
  projectInfo: IWorkingProjectInfo,
  fileMeta: IFileMetadata,
): Promise<void> {
  const promises = [];
  const { sourceBaseUrl, targetFileName } = fileMeta;

  for (const filename of fileMeta.sourceFilenames) {
    promises.push(axios.get(sourceBaseUrl + filename).then(({ data }) => data));
  }

  const filesData = await Promise.all(promises);
  let file = {};

  for (const fileData of filesData) {
    file = {
      ...file,
      ...fileData,
    };
  }

  return fs.writeFile(
    path.join(
      projectInfo.path,
      InstrumentMetadataConfig.targetProjectDestinations[projectInfo.name],
      targetFileName,
    ),
    JSON.stringify(file, null, 2),
  );
}
