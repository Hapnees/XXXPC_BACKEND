export interface IError {
  msg: string
  key: string
  value: string
}

export interface IErrorGlobal {
  id: number
  errors: IError[]
}
