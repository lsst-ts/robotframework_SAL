*** Settings ***
Documentation    AtMonochromator_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 243 180 178 34 82 243 241 198 79 255 190 76 238 161 97 21 120 62 67 239 32 25 122 19 133 76 3 8 25 23 126 168 82 182 222 123 229 28 118 100 252 2 159 79 248 76 88 221 227 213 193 2 121 147 247 211 57 12 208 71 59 137 150 121 51 126 37 180 125 111 202 196 182 236 82 224 61 225 171 211 148 195 111 177 113 159 94 194 214 176 222 208 127 169 132 185 92 206 207 167 199 184 211 71 197 121 196 58 247 25 205 214 150 122 173 77 217 155 136 42 85 207 227 70 62 214 118 178 8 37 28 21 47 47 233 224 187 224 233 122 8 48 213 105 231 27 41 5 131 122 12 235 186 25 142 188 170 66 171 141 30 222 148 95 156 151 102 52 170 63 214 69 18 103 147 166 207 105 0 196 191 68 71 249 136 176 63 149 174 24 165 68 220 176 39 79 250 247 164 54 17 223 122 17 43 147 4 39 148 137 72 44 24 159 29 254 113 164 207 4 247 117 79 186 185 101 191 222 132 18 153 38 144 236 168 68 53 186 116 205 213 182 128 211 241 125 78 64 196 141 192 34 114 220 101 132 255 98 41 221 228 194 179 80 83 35 147 62 82 133 113 21 175 120 24 103 233 14 156 140 173 110 0 23 74 5 15 138 243 83 176 17 54 169 242 191 95 23 25 245 191 163 138 62 123 201 86 73 228 50 216 231 16 14 181 58 61 27 169 119 64 113 197 6 66 96 57 119 119 231 186 31 238 206 155 219 160 98 25 200 83 116 210 145 151 156 182 144 220 37 129 38 231 90 18 210 150 166 229 229 145 34 156 142 71 227 27 214 244 214 147 20 201 93 126 116 180 24 51 42 224 32 103 6 14 82 123 72 196 167 145 55 57 205 71 236 57 176 170 22 142 252 247 138 206 40 0 190 225 91 79 227 157 133 111 115 179 149 185 107 75 194 201 102 140 55 152 106 3 139 226 135 232 139 125 133 58 101 150 202 87 6 80 249 46 247 28 141 98 217 46 191 160 164 114 33 75 98 99 156 157 83 218 221 106 52 60 190 221 48 78 115 231 21 223 9 27 8 20 137 189 7 169 245 85 56 153 178 83 231 104 236 39 125 180 189 58 69 240 153 189 132 93 213 230 244 44 131 197 116 41 174 64 204 136 238 106 196 156 221 59 48 255 236 223 83 216 120 183 90 254 7 208 173 13 185 210 24 140 62 144 235 192 117 90 148 79 219 120 241 71 113 35 173 177 102 147 162 53 179 125 173 129 181 132 194 166 247 97 244 194 200 62 89 172 20 193 28 33 74 94 69 6 18 162 226 155 119 203 193 231 95 18 165 136 8 16 191 124 203 197 223 166 171 174 80 97 194 174 19 147 101 142 123 140 82 168 211 39 175 226 240 65 235 102 22 159 144 113 0 217 129 57 99 164 173 153 208 255 72 71 246 55 195 91 134 93 107 54 130 120 212 24 75 8 155 188 9 174 221 137 129 8 70 143 22 67 80 122 159 224 236 39 219 161 148 20 20 87 67 49 79 144 118 63 199 72 116 157 42 111 230 127 211 235 38 115 56 83 62 101 27 138 232 102 73 160 48 114 207 75 72 40 225 164 141 213 137 58 166 135 54 12 53 78 54 244 30 2 46 231 247 180 163 222 51 38 254 39 15 4 252 253 173 10 234 247 12 94 101 174 201 88 162 64 111 5 129 200 23 1 45 33 34 45 69 206 251 42 101 178 125 71 79 145 24 15 181 113 52 49 193 153 151 224 226 102 8 123 92 190 1 0 93 23 176 121 62 102 237 215 35 202 169 176 171 203 68 6 22 101 148 239 106 165 109 250 102 94 27 169 103 167 170 180 184 93 90 91 181 82 143 152 93 60 93 11 159 95 29 142 58 64 39 53 160 209 140 123 227 182 110 61 243 59 6 92 159 117 0 156 201 27 23 140 131 62 134 68 242 32 38 31 111 84 64 54 71 131 200 96 228 80 36 184 79 126 113 152 7 243 55 203 209 77 69 64 113 89 16 203 30 37 237 56 10 87 53 240 211 184 119 244 129 192 68 6 96 33 34 74 142 149 87 46 96 90 187 103 10 21 247 12 117 185 238 91 72 153 130 155 12 217 3 254 135 56 173 121 54 53 47 85 118 219 141 219 89 75 147 124 134 121 33 128 232 38 75 130 236 205 230 118 180 67 6 116 31 222 145 64 0 39 175 160 51 125 92 5 101 166 245 186 105 26 75 17 45 160 106 84949172
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
