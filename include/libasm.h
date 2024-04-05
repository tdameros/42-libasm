/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdameros <tdameros@student.42lyon.fr>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/05 23:20:00 by tdameros          #+#    #+#             */
/*   Updated: 2024/04/05 23:20:00 by tdameros         ###   ########lyon.fr   */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_BUILD_INCLUDE_LIBASM_H_
# define LIBASM_BUILD_INCLUDE_LIBASM_H_

ssize_t ft_read(int fd, void *buf, size_t count);
int ft_strcmp(const char *s1, const char *s2);
char *ft_strcpy(char *dst, const char *src);
char *ft_strdup(const char *s1);
size_t ft_strlen(const char *str);
ssize_t ft_write(int fd, const void *buf, size_t count);

#endif