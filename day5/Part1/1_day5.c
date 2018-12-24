/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   1_day5.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/19 14:56:22 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/24 11:44:32 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libft/libft.h"
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

static int	make_reactions(char **str)
{
	int	i;
	int	j;
	int	k;
	char	*tmp;
	int	len;

	i = 0;
	tmp = *str;
	len = ft_strlen(tmp);
	while (i < len - 1)
	{
		if ((tmp[i] >= 97 && tmp[i] <= 122 && tmp[i + 1] == tmp[i] - 32)
				|| (tmp[i] >= 65 && tmp[i] <= 90 && tmp[i + 1] == tmp[i] + 32))
		{
			if (!(*str = malloc(sizeof(char) * (len - 2))))
				return (-1);
			j = 0;
			k = 0;
			while (tmp[j] && j < len)
			{
				if (j == i)
					j += 2;
				(*str)[k] = tmp[j];
				j++;
				k++;
			}
			(*str)[k] = '\0';
			if (tmp)
				ft_strdel(&tmp);
			return (1);
		}
		i++;
	}
	return (0);
}

static void	read_input(char *input, char **str)
{
	int	fd;
	char	*line;

	line = NULL;
	fd = open(input, O_RDONLY);
	while (get_next_line(fd, &line))
	{
		if (!(*str = malloc(sizeof(char) * ft_strlen(line))))
			return ;
		*str = ft_strdup(line);
		ft_strdel(&line);
	}
	close(fd);
}

int		main(int ac, char **av)
{
	char	*str;
	int	i;
	int	str_len;

	str = NULL;
	i = 0;
	if (ac == 2)
	{
		read_input(av[1], &str);
		while (make_reactions(&str))
			i++;
		str_len = ft_strlen(str);
		ft_strdel(&str);
		ft_putnbr(str_len);
		ft_putchar('\n');
	}
	return (0);
}
