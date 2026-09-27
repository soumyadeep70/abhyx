import { NextFunction, Request, Response } from 'express';
import { ZodTypeAny } from 'zod';

interface ValidationSchemas {
  body?: ZodTypeAny;
  params?: ZodTypeAny;
  query?: ZodTypeAny;
}

/** Validates and REPLACES req.body/params/query with the parsed (typed, defaulted) result. */
export function validate(schemas: ValidationSchemas) {
  return (req: Request, _res: Response, next: NextFunction) => {
    if (schemas.body) req.body = schemas.body.parse(req.body);
    if (schemas.params) req.params = schemas.params.parse(req.params) as any;
    if (schemas.query) {
      const parsed = schemas.query.parse(req.query);
      // Express 5 turned req.query into a getter-only accessor (no setter),
      // so `req.query = parsed` throws "Cannot set property query of
      // #<IncomingMessage> which has only a getter". Redefining the
      // property is Express's own documented workaround -- see
      // https://expressjs.com/en/guide/migrating-5.html
      Object.defineProperty(req, 'query', {
        value: parsed,
        writable: true,
        enumerable: true,
        configurable: true,
      });
    }
    next();
  };
}
