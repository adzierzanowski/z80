/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f0xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define BUS_AL_Pin GPIO_PIN_13
#define BUS_AL_GPIO_Port GPIOC
#define BUS_AH_Pin GPIO_PIN_14
#define BUS_AH_GPIO_Port GPIOC
#define BUS_D_Pin GPIO_PIN_15
#define BUS_D_GPIO_Port GPIOC
#define BUS_PL_Pin GPIO_PIN_0
#define BUS_PL_GPIO_Port GPIOF
#define BUS_CP_Pin GPIO_PIN_1
#define BUS_CP_GPIO_Port GPIOF
#define CLK_Pin GPIO_PIN_6
#define CLK_GPIO_Port GPIOA
#define RST_Pin GPIO_PIN_7
#define RST_GPIO_Port GPIOA
#define INT_Pin GPIO_PIN_1
#define INT_GPIO_Port GPIOB
#define LED_Pin GPIO_PIN_2
#define LED_GPIO_Port GPIOB
#define NMI_Pin GPIO_PIN_10
#define NMI_GPIO_Port GPIOB
#define HLT_Pin GPIO_PIN_11
#define HLT_GPIO_Port GPIOB
#define HLT_EXTI_IRQn EXTI4_15_IRQn
#define BUSACK_Pin GPIO_PIN_12
#define BUSACK_GPIO_Port GPIOB
#define BUSRQ_Pin GPIO_PIN_13
#define BUSRQ_GPIO_Port GPIOB
#define MEMRQ_Pin GPIO_PIN_14
#define MEMRQ_GPIO_Port GPIOB
#define IORQ_Pin GPIO_PIN_15
#define IORQ_GPIO_Port GPIOB
#define WAIT_Pin GPIO_PIN_8
#define WAIT_GPIO_Port GPIOA
#define RD_Pin GPIO_PIN_9
#define RD_GPIO_Port GPIOA
#define WR_Pin GPIO_PIN_10
#define WR_GPIO_Port GPIOA
#define BUS_CS_Pin GPIO_PIN_15
#define BUS_CS_GPIO_Port GPIOA
#define TFT_CS_Pin GPIO_PIN_4
#define TFT_CS_GPIO_Port GPIOB
#define SEGDISP_CS_Pin GPIO_PIN_6
#define SEGDISP_CS_GPIO_Port GPIOB
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
