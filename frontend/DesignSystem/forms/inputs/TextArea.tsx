import React, { HTMLProps } from "react";
import classNames from "classnames";

export const INPUT_ERROR_STYLES = "border-2 border-danger-500";

export type TextAreaProps = HTMLProps<HTMLTextAreaElement> & {
  invalid?: boolean;
  value?: string | undefined;
  placeholder?: string | undefined;
};

const TextArea = (props: TextAreaProps) => {
  let classes = classNames(
    props.className,
    "block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
  );

  if (props.invalid) {
    classes = classNames(classes, INPUT_ERROR_STYLES);
  } else {
    classes = classNames(classes, "border");
  }

  const { invalid, ...nativeProps } = props;
  return <textarea {...nativeProps} className={classes} />;
};

export default TextArea;
