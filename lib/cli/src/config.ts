const baseURL =
  'https://raw.githubusercontent.com/tyrcord/tbase/master/financial/';

export const InstrumentMetadataConfig: IInstrumentMetadata = {
  filesToCombine: [
    {
      sourceBaseUrl: `${baseURL}pairs/`,
      sourceFilenames: [
        `commodities.json`,
        `cryptos.json`,
        `exotics.json`,
        `majors.json`,
        `minors.json`,
        `metadata.json`,
        `indexes.json`,
      ],
      targetFileName: 'pairs.json',
    },
    {
      sourceBaseUrl: `${baseURL}instruments/`,
      sourceFilenames: [
        `commodities.json`,
        `cryptos.json`,
        `currencies.json`,
        `metadata.json`,
        `indexes.json`,
      ],
      targetFileName: 'instruments.json',
    },
  ],
  supportedProjects: ['matex', 'matex_dart'],
  targetProjectDestinations: {
    matex: 'packages/providers/src/meta',
    matex_dart: 'assets/meta',
  },
};

export interface IInstrumentMetadata {
  filesToCombine: IFileMetadata[];
  supportedProjects: string[];
  targetProjectDestinations: { [key: string]: string };
}

export interface IFileMetadata {
  sourceBaseUrl: string;
  sourceFilenames: string[];
  targetFileName: string;
}
