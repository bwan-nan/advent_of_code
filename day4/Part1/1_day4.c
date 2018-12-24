/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   1_day4.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/19 14:56:22 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/23 18:19:22 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libft/libft.h"
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

static void	sort_input(char *input)
{
	int	fd;
	char	*line;

	line = NULL;
	fd = open(input, O_RDONLY);
	while (get_next_line(fd, &line))
	{
		ft_putnbr(ft_atoi(ft_strchr(line, '-') + 1));
		ft_putchar(' ');
		ft_putnbr(ft_atoi(ft_strchr(line, '-') + 4));
		ft_putchar('\n');
		ft_strdel(&line);
	}
	close(fd);
}

int		main(int ac, char **av)
{
	if (ac == 2)
	{
		sort_input(av[1]);
	}
	return (0);
}
